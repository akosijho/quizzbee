<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\PlayerNameController;
use App\Http\Controllers\Api\QuestionnareController;
use App\Http\Controllers\ParticipantController;
use App\Http\Controllers\QuestionController;
use App\Http\Controllers\GuestController;

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

//Save Participants-flutter
//Required Body{'name'}
Route::post('/participant', [ParticipantController::class,'save'])->name('participant.save');
// ----------------------------------------------------------


//-----------------------Question------------------------
//Display Question and choices - flutter
Route::get('/question', [QuestionController::class,'index'])->name('question.index');

//Answer Checker - flutter
// Required Body{'answer','id'}
Route::post('/check', [QuestionController::class,'check'])->name('question.check');
// ----------------------------------------------------------


//-----------------------Game Master------------------------
//Next question
//Required Body{'id'}
Route::post('/next', [GuestController::class,'next'])->name('guest.next');
// ----------------------------------------------------------