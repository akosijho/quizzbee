<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Status;
use DB;
use Pusher\Pusher;

class StatusController extends Controller
{
    function __construct()
    {
        $this->status = new Status;
        $this->pusher = new Pusher(
            env('PUSHER_APP_KEY'),
            env('PUSHER_APP_SECRET'),
            env('PUSHER_APP_ID'),
            [
                'cluster' => env('PUSHER_APP_CLUSTER'),
                'useTLS' => true,
            ]
        );
    }

    public function status()
    {
        $data = $this->status->getStatus();
        if ($data['status'] == 0)
        {
            DB::table('statuses')->update(['status' => 1]);
            return response()->json("true");
        }
        else
        {
            DB::table('statuses')->update(['status' => 0]);
            return response()->json("false");
        }
    }


    public function waiting_room()
    {
        $data = $this->status->getWaitingRoom();
        if ($data['waiting_room'] == 0)
        {
            DB::table('statuses')->update(['waiting_room' => 1]);
            
            $this->pusher->trigger('my-channel', 'waiting-event', $data); 
            // return response()->json("true");
        }
        else
        {
            DB::table('statuses')->update(['waiting_room' => 0]);
            
            $this->pusher->trigger('my-channel', 'waiting-event', $data); 
            // return response()->json("false");
        }
    }

    public function finish()
    {
        $data = $this->status->getFinish();
        if ($data['waiting_room'] == 0)
        {
            DB::table('statuses')->update(['finish' => 1]);
            // return response()->json("true");
            
         $this->pusher->trigger('my-channel', 'finish-event', $data); 
        }
        else
        {
            DB::table('statuses')->update(['finish' => 0]);
            // return response()->json("false");
            
         $this->pusher->trigger('my-channel', 'finish-event', $data); 
        }
    }

    public function getWaitingRoom()
    {
        $data = $this->status->getWaitingRoom();
        return response()->json($data['waiting_room']);
    }

    public function getFinish()
    {
        $data = $this->status->getFinish();
        return response()->json($data['finish']);
    }
}
