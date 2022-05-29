var me = {token:null, player_id:null};
var game_status = {};
var last_update=new Date().getTime();
var timer=null;

$(function(){
    draw_empty_board();
    fill_board();
    fill_pieces();
    game_status_update();
    $('#pieces').hide();
    $('#quarto_login').click(login_to_game);
    $('#do_move').click(do_move);
    $('#do_move2').click(do_move);
    //$('#quarto_reset').click(reset_board);
    $('#do_move').hide();
});

function draw_empty_board() {
    var t = '<table id="quarto_table">';
    for(var i=4; i>0; i--) {
        t += '<tr>';
        for(var j = 1; j<5; j++) {
            t += '<td id="circle_'+i+'_'+j+'">' + '</td>';
        }
        t+='</tr>';
    } 
    t += '</table>';
    $('#quarto_board').html(t);
}


function fill_pieces(){
    $.ajax({url: "quarto.php/board/piecesload/", headers: {"X-Token": me.token}, success: fill_pieces_by_data});
}

function fill_board(){
    $.ajax({url: "quarto.php/board/", headers: {"X-Token": me.token}, success: fill_board_by_data}); 
}

function fill_board_by_data(data) {
    for(var i=0; i<data.length; i++) {
        var o = data[i];
        var id = '#circle_'+ o.posX + '_' + o.posY;
        var c = (o.piece==null)?o.posX + ',' + o.posY: o.piece;
        $(id).html(c);
    }
}

function fill_pieces_by_data(data){
    for(var i=0; i<data.length; i++) {
        var o = data[i];
        var id = o.piece_id;
        var c = o.piece_id;
        $('#pieces_column option[value="'+id+'"]').text(c);
    }
}

function login_to_game() {
    // if ($('#username').val() == '') {
    //     alert('You have to set a valid username');
    //     return;
    // }
    var userName = $('#username').val();
    var playerId = $('#player_id').val();
    $.ajax({url: "quarto.php/players/"+ playerId, 
            method: 'PUT', 
            dataType: "json", 
            headers: {"X-Token": me.token},
            contentType: 'application/json',
            data: JSON.stringify({username: userName, player_id: playerId}),
            success: login_result,
            error: login_error});
}    

function login_result(data) {
    me = data[0];
    $('#game_initializer').hide();
    $('#pieces').show();
    update_info();
    game_status_update();

}

function login_error(data,y,z,c) {
    var x = data.responseJSON;
    alert(x.errormesg);
}

function update_status(data) {
	last_update=new Date().getTime();
	var game_stat_old = game_status;
	game_status=data[0];
	update_info();
	clearTimeout(timer);
	if(game_status.player_turn==me.player_id &&  me.player_id!=null) {
		x=0;
		// do play
		if(game_stat_old.player_turn!=game_status.player_turn) {
			fill_board();
		}
		$('#move_div').show(1000);
		timer=setTimeout(function() { game_status_update();}, 15000);
	} else {
		// must wait for something
		$('#move_div').hide(1000);
		timer=setTimeout(function() { game_status_update();}, 4000);
	}
 	
}

function do_move() {
	var s = $('#the_move').val();
	var a = s.trim().split(/[ ]+/);
    var pid = ""+$('#pieces_column option:selected').val();
    console.log(pid);
	if(a.length!=2) {
		alert('Must give 2 numbers');
		return;
	}
	$.ajax({url: "quarto.php/board/piece/"+ pid, 
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {x: a[0], y: a[1], pid:pid}),
			headers: {"X-Token": me.token},
			success: move_result,
			error: login_error});
	
}

function move_result(data){
	game_status_update();
	fill_board_by_data(data);
}

function update_info(){
	$('#game_info').html("<b>I am Player : </b>"+me.player_id+"<br><b>Username : </b>"+me.username +'<br><b>Token : </b>'+me.token+'<br><b>Game state : </b>'+game_status.status+'<br><b>Turn : </b>'+ game_status.player_turn+'<b> must play now</b>');
}

function game_status_update() {
	clearTimeout(timer);
	$.ajax({url: "quarto.php/status/",headers: {"X-Token": me.token}, success: update_status,headers: {"X-Token": me.token} });
}


