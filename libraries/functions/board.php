<?php 

function show_board() {
    global $mysqli;

    $sql = 'select * from board';
    $st = $mysqli->prepare($sql);
    
    $st->execute();
    $res = $st->get_result();

    header('Content-type: application/json');
    print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
}

    function show_piece($request) {
        global $mysqli;
        
        $sql = 'select * from pieces where piece_id=?';
        $st = $mysqli->prepare($sql);
        $st->bind_param('i',$request);
        $st->execute();
        $res = $st->get_result();
        header('Content-type: application/json');
        print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
    }

    function move_piece($x2,$y2,$pid,$token) {
	
        if($token==null || $token=='') {
            header("HTTP/1.1 400 Bad Request");
            print json_encode(['errormesg'=>"token is not set."]);
            exit;
        }
        
        $player = current_player($token);
        if($player==null ) {
            header("HTTP/1.1 400 Bad Request");
            print json_encode(['errormesg'=>"You are not a player of this game."]);
            exit;
        }
        $status = read_status();
        if($status['status']!='started') {
            header("HTTP/1.1 400 Bad Request");
            print json_encode(['errormesg'=>"Game is not in action."]);
            exit;
        }
        if($status['player_turn']!=$player) {
            header("HTTP/1.1 400 Bad Request");
            print json_encode(['errormesg'=>"It is not your turn."]);
            exit;
        }
       
        do_move($pid,$x2,$y2);
              
        //header("HTTP/1.1 400 Bad Request");
        //print json_encode(['errormesg'=>"This move is illegal."]);
        exit;
    }

    function show_pieces() {
        global $mysqli;
    
        $sql = 'select * from pieces';
        $st = $mysqli->prepare($sql);
        
        $st->execute();
        $res = $st->get_result();
    
        header('Content-type: application/json');
        print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
    }

    function do_move($pid,$x2,$y2) {
        global $mysqli;
        $sql = 'update board set piece=? where posX=? and posY=?';
        $st = $mysqli->prepare($sql);
        $st->bind_param('sii',$pid,$x2,$y2 );
        $st->execute();
    
        header('Content-type: application/json');
        print json_encode(read_board(), JSON_PRETTY_PRINT);
    }

    function read_board() {
        global $mysqli;
        $sql = 'select * from board';
        $st = $mysqli->prepare($sql);
        $st->execute();
        $res = $st->get_result();
        return($res->fetch_all(MYSQLI_ASSOC));
    }


    function reset_board() {
        global $mysqli;

        $sql = 'call clean_board()';
        $mysqli->query($sql);
        show_board();
    }
?>