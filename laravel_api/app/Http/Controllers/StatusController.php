<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Status;
use DB;

class StatusController extends Controller
{
    function __construct()
    {
        $this->status = new Status;
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
            return response()->json("true");
        }
        else
        {
            DB::table('statuses')->update(['waiting_room' => 0]);
            return response()->json("false");
        }
    }

    public function finish()
    {
        $data = $this->status->getFinish();
        if ($data['waiting_room'] == 0)
        {
            DB::table('statuses')->update(['finish' => 1]);
            return response()->json("true");
        }
        else
        {
            DB::table('statuses')->update(['finish' => 0]);
            return response()->json("false");
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
