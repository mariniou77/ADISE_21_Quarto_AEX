<?php
require_once "../libraries/conn/connection.php";
require_once "../libraries/functions/board.php";
require_once "../libraries/functions/game.php";
require_once "../libraries/functions/users.php";


$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
$input = json_decode(file_get_contents('php://input'),true);
if($input==null) {
    $input=[];
}
if(isset($_SERVER['HTTP_X_TOKEN'])) {
    $input['token']=$_SERVER['HTTP_X_TOKEN'];
} else {
    $input['token']='';
}

switch ($r = array_shift($request)) {
    case 'board' :
        switch ($b = array_shift($request)) {
            case '':
            case null: handle_board($method);
                break;  
            case 'piece': handle_piece($method, $request, $input);
                break;
            case 'piecesload' : handle_piecesload($method);
            break;
            default: header("HTTP/1.1 404 Not Found");           
        }
        break; 
    case 'status' : 
        if(sizeof($request)==0) {
            handle_status($method);
        } else {
            header("HTTP/1.1 404 Not Found");
        }
        break;
    case 'players' : handle_player($method, $request, $input);
        break;
    default: header("HTTP/1.1 404 Not Found");
    exit;            
}

function handle_board($method) {

    if($method == 'GET'){
        show_board();
    }else if ($method == 'POST') {
        reset_board();
    }else {
        header('HTTP/1.1405 Method Not Allowed');
    }
}  

function handle_piecesload($method) {

    if($method == 'GET'){
        show_pieces();
    }else if ($method == 'POST') {
        reset_board();
    }else {
        header('HTTP/1.1405 Method Not Allowed');
    }
}  

 function handle_piece($method, $pid, $input) {
    if($method=='GET') {
        show_piece($pid);
    } else if ($method=='PUT') {
        move_piece($input['x'],$input['y'], $input['pid'],
                   $input['token']);
    }   
 }
function handle_player($method, $p,$input) {
    switch ($b=array_shift($p)) {
	//	case '':
	//	case null: if($method=='GET') {show_users($method);}
	//			   else {header("HTTP/1.1 400 Bad Request"); 
	//					 print json_encode(['errormesg'=>"Method $method not allowed here."]);}
    //                break;
        case 'Player1': 
		case 'Player2': handle_user($method, $b,$input);
					break;
		default: header("HTTP/1.1 404 Not Found");
				 print json_encode(['errormesg'=>"Player $b not found."]);
                 break;
	}
}

function handle_status($method) {
    if($method == 'GET'){
        show_status();
    }else {
        header('HTTP/1.1405 Method Not Allowed');
    }
}
?>