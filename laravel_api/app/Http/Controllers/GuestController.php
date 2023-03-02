<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Question;

class GuestController extends Controller
{
    function __construct()
    {
        $this->question = new Question;
    }

    public function next(Request $request)
    {
        $this->question->nextQuestion($request->id);
        return response()->json("ok");
    }
}
