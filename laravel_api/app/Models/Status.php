<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Status extends Model
{
    use HasFactory;
    protected $fillable = ['status'];

    public function getStatus()
    {
        return $this->select('status')->first();
    }

    public function getWaitingRoom()
    {
        return $this->select('waiting_room')->first();
    }

    public function getFinish()
    {
        return $this->select('finish')->first();
    }
}
