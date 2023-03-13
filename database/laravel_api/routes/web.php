<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\admin\DashboardController;
use App\Http\Controllers\admin\QuestionController;
use App\Http\Controllers\admin\SettingsController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


// question
Route::get('/question', [QuestionController::class,'index'])->name('question.index');
Route::post('/question', [QuestionController::class,'save'])->name('question.save');



// dashboard
Route::get('/dashboard', [DashboardController::class,'index'])->name('dashboard.index');


// setings
Route::get('/settings', [SettingsController::class,'index'])->name('settings.index');
Route::post('/settings', [SettingsController::class,'reset'])->name('settings.reset');