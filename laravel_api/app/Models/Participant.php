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

    public function getTopParticipants()
    {
        return $this->orderBy('score','desc')->limit(10)->get();
    }

    public function saveParticipant($data)
    {
        return $this->insertGetId($data);
    }

    public function pointsParticipant($id)
    {
        return $this->select('score')->whereid($id)->first();
    }
}
