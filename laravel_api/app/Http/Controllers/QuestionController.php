<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Question;
use DB;

class QuestionController extends Controller
{

    function __construct()
    {
        $this->question = new Question;
    }



    public function index()
    {
        $data = $this->question->getQuestion();     
        return response()->json($data);
    }

    public function getQuestionIds()
    {
        $data = $this->question->getQuestionIds();

        return response()->json($data);
    }

    public function check(Request $request)
    {
        $data = $this->question->checkQuestion($request->answer);
        if ($data) 
        {
            DB::table('participants')->whereid($request->id)->increment('score', 2);
            return response()->json("you are correct");
        }
        else{
            return response()->json("oops");
        }

    }




    public function save(Request $request)
    {
        $data = [

            'question' => $request->question,
            'answer' => $request->answer

        ];
        $this->question->saveQuestion($data);
        return redirect()->route('question.index');
    }




    public function update(Request $request)
    {
        $data = [

            'question' => $request->question,
            'answer' => $request->answer
        ];
        $this->question->updateQuestion(1,$data);
        return redirect()->route('question.index');
    }




    public function delete()
    {
        $this->question->deleteQuestion(1);
        return redirect()->route('question.index');
    }


}
