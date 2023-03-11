<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Choice;

class Question extends Model
{
    use HasFactory;
    protected $fillable = ['question','answer','status', 'tag'];
    

    public function choice()
    {
        return $this->hasMany(Choice::class);
    }

    public function checkQuestion($answer){
        return $this->select('question')->where('answer',$answer)->first();
    }


    public function getQuestion()
    {
        return $this->with('choice')->where('status',1)->limit(1)->get();
    }

    public function saveQuestion($data)
    {
        return $this->create($data);
    }

    public function getQuestionIds()
    {
        return $this->select('id')->orderBy('id', 'asc')->get();
        
    }

    public function updateQuestion($id, $data)
    {
        $question = $this->find($id);
        $question->update($data);
    }

    public function deleteQuestion($id)
    {
        $question = $this->whereid($id);
        $question->delete();
    }

    public function searchQuestion($id)
    {
        return $this->find($id);
    }

    public function nextQuestion($id)
    {
        $question = $this->whereid($id);
        $question->update([
            'status' => 0
        ]);
    }

    public function getIdQuestion($data)
    {
        return $this->insertGetId($data);
    }




}
