<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Question;
use App\Models\Choice;

class QuestionController extends Controller
{

   function __construct()
    {
        $this->question = new Question;
        $this->choice = new Choice;
    }


    public function index()
    {
        return view('admin.question');
    }


    public function save(Request $request)
    {
        $question = [
            'question' => $request->message,
            'answer' =>$request->answer,
            'status' => 1
        ];

        $id = $this->question->getIdQuestion($question);

        foreach($request->choices as $choice)
        {
            $choices = [
                'choices' => $choice,
                'question_id' => $id
            ];
            $this->choice->addChoice($choices);

        }
        return redirect()->route('dashboard.index');
    }
}
