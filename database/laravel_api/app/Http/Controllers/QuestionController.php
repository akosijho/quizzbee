<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Question;
use DB;
use Pusher\Pusher;

class QuestionController extends Controller
{
    private $pusher;
    function __construct()
    {
        $this->question = new Question;
        $this->question = new Question;

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



    public function index()
    {
        $data = $this->question->getQuestion();   
        if($data != []){
            $this->pusher->trigger('my-channel', 'my-event', $data);  
        }
        // return response()->json($data);
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

    //  public function getResponseQuestion()
    // {
    //      $status = DB::table('questions')->whereid(1)->first();
    //      return response()->json($status['id']);
    // }
    




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
