<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Question;

class Choice extends Model
{
    use HasFactory;
    protected $fillable = ['choices','question_id'];

    public function question()
    {
        return $this->belongsTo(Question::class, 'question_id', 'id');
    }

    public function addChoice($data)
    {
        return $this->create($data);
    }
}
