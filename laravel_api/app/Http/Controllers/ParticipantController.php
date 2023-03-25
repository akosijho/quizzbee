<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Participant;
use App\Models\Status;

class ParticipantController extends Controller
{
    function __construct()
    {
        $this->participant = new Participant;
        $this->status = new Status;
    }


    public function index()
    {
        $data = $this->participant->getParticipants();
        return $this->orderBy('score','desc')->get();
        return response()->json($data);

      
    }

    public function top()
    {
        $data = $this->participant->getTopParticipants();
        return response()->json($data);
    }
    

    public function save(Request $request)
    {
        $data2 = $this->status->getWaitingRoom();

    
        if ($data2['waiting_room'] == 0)
        {
            $data = [
            'name' => $request->name,
            'score' => 0
             ];
            $id = $this->participant->saveParticipant($data);
            return response()->json(['id' => $id, 'message' => 'Waiting for the game master to start the game']);
        }
        else
        {
            
            $data = [
            'name' => $request->name,
            'score' => 0
             ];
            $id = $this->participant->saveParticipant($data);
            return response()->json(['id' => $id, 'message' => 'no message']);
        }

    }


   








    public function points($id)
    {
        $data = $this->participant->pointsParticipant($id);
        return response($data);
    }
}
