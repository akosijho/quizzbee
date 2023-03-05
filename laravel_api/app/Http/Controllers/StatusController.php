<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Status;
use DB;

class StatusController extends Controller
{
    function __construct()
    {
        $this->status = new Status;
    }

    public function status()
    {
        $data = $this->status->getStatus();
        if ($data['status'] == 0)
        {
            DB::table('statuses')->update(['status' => 1]);
        }
        else
        {
            DB::table('statuses')->update(['status' => 0]);
        }
    }
}
