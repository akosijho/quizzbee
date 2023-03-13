<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Question;
use Pusher\Pusher;

class GuestController extends Controller
{
    private $pusher;
    function __construct()
    {
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

    public function next(Request $request)
    {
        $this->question->nextQuestion($request->id);
        // return response()->json("ok");
        $data = $this->question->getQuestion();   
        $this->pusher->trigger('my-channel', 'my-event', $data);
    }
}
