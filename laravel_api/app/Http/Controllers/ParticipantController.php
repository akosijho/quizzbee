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
        return response()->json($data);
    }




    public function save(Request $request)
    {
        $data = $this->status->getStatus();

        if ($data['status'] == 0)
        {
            return response()->json('The game has not yet started');
        }

        else
        {
            $data = [
            'name' => $request->name,
            'score' => 0
             ];
            $id = $this->participant->saveParticipant($data);
            return response()->json($id);
        }

    }





    public function points($id)
    {
        $data = $this->participant->pointsParticipant($id);
        return response()->json($data);
    }
}
