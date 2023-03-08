<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\PlayerNameController;
use App\Http\Controllers\Api\QuestionnareController;
use App\Http\Controllers\ParticipantController;
use App\Http\Controllers\QuestionController;
use App\Http\Controllers\GuestController;
use App\Http\Controllers\StatusController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});







//-----------------------participant---------------------
//leaderboards-Vue.js
Route::get('/participant', [ParticipantController::class,'index'])->name('participant.index');


Route::get('/top', [ParticipantController::class,'top'])->name('participant.top ');

//Save Participants-flutter
//Required Body{'name'}
Route::post('/participant', [ParticipantController::class,'save'])->name('participant.save');
// ----------------------------------------------------------


//-----------------------Question---------------------
//Display Question and choices - flutter
Route::get('/question', [QuestionController::class,'index'])->name('question.index');

// get question ids
Route::get('/question_indexes', [QuestionController::class, 'getQuestionIds'])->name('question.ids');

//Answer Checker - flutter
// Required Body{'answer','id'}
// answer sa player
//  id sa player
Route::post('/check', [QuestionController::class,'check'])->name('question.check');
// ----------------------------------------------------------






// ------------------------points--------------------------
//Display points - flutter
//Required Parameter{'id'} - challenger id
Route::get('/participant/{id}', [ParticipantController::class,'points'])->name('participant.points');
// --------------------------------------------------------


//Start or Stop - flutter
Route::post('/status', [StatusController::class,'status'])->name('status');




//-----------------------Game Master------------------------
//Next question
//Required Body{'id'}
// id sa question
Route::post('/next', [GuestController::class,'next'])->name('guest.next');
// ----------------------------------------------------------










Route::post('/waiting_room', [StatusController::class,'waiting_room'])->name('waiting_room');
Route::get('/getresponse', [StatusController::class,'getWaitingRoom'])->name('get_waiting_room');


Route::post('/finish', [StatusController::class,'finish'])->name('finish.finish');
Route::get('/finish', [StatusController::class,'getFinish'])->name('finish.get');

