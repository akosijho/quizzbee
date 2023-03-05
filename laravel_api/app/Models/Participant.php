<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Participant extends Model
{
    use HasFactory;
    protected $guarded = [];

    public function getParticipants()
    {
        return $this->orderBy('score','desc')->get();
    }

    public function saveParticipant($data)
    {
        return $this->insertGetId($data);
    }
}
