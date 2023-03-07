<?php

namespace App\Http\Controllers\admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DB;

class SettingsController extends Controller
{


    public function index()
    {
        return view('admin.settings');

    }



    public function reset()
    {
        DB::table('questions')->update([
            'status' => '1'
        ]);
        DB::table('statuses')->update([
            'waiting_room' => '0'
        ]);
        return redirect()->route('settings.index');
    }
}
