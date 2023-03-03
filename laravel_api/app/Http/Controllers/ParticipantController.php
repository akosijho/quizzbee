<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Participant;

class ParticipantController extends Controller
{
    function __construct()
    {
        $this->participant = new Participant;
    }


    public function index()
    {
        $data = $this->participant->getParticipants();
        return response()->json($data);
    }

    public function save(Request $request)
    {
        $data = [
            'name' => $request->name,
            'score' => 0
        ];
       $id = $this->participant->saveParticipant($data);
        return response()->json($id);

    }
}
