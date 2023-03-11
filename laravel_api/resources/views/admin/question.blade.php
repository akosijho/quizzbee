@extends('admin.layout')
@section('content')
<div class="container-fluid">
<form action="{{ route('question.save') }}" method="POST">
	@csrf
  <div class="mb-3" style="display: flex; justify-content:center; align-items: flex-start; flex-direction: column;">
    <label for="question" class="form-label">Question</label>
    <textarea name="message" class="form-label" style="width: 100%; border: 1px solid grey;"></textarea>
  </div>
  <div class="mb-3" style="display: flex; justify-content:center; align-items: flex-start; flex-direction: column;">
    <label for="answer_identification" class="form-label">Answer For Identtification</label>
    <textarea name="answer_iden" class="form-label" style="width: 100%; border: 1px solid grey;"></textarea>
  </div>
  <div class="mb-3">
    <label for="choices" class="form-label">Choices</label>
    <button type="button" style="display: flex; justify-content: center; align-items: center; margin-bottom: 1rem;" class="btn btn-info" onclick="addTextBox()" style="height: 20px;">+</button>
    <div class="text" style="display: flex; justify-content: center; align-items: center; gap: 4px; flex-direction: column;">
    </div>
    <div class="text" style="margin-top: 1rem; ">
    	<label for="answer" class="form-label">Answer</label>
    	<select class="form-select" aria-label="Default select example" id="answer" name="answer">
		  <option selected>Choose Answer</option>
		  <option value="a">a</option>
		  <option value="b">b</option>
		  <option value="c">c</option>
		  <option value="d">d</option>
		  <option value="e">e</option>
		  <option value="f">f</option>
		  <option value="g">g</option>
		  <option value="h">h</option>
		  <option value="i">i</option>
		  <option value="j">j</option>
		  <option value="k">k</option>
		  <option value="l">l</option>
		  <option value="m">m</option>
		  <option value="n">n</option>
		  <option value="o">o</option>
		  <option value="p">p</option>
		  <option value="q">q</option>
		  <option value="r">r</option>
		  <option value="s">s</option>
		  <option value="t">t</option>
		  <option value="u">u</option>
		  <option value="v">v</option>
		  <option value="w">w</option>
		  <option value="x">x</option>
		  <option value="y">y</option>
		  <option value="z">z</option>
		</select>
    </div>
  </div>
  <button type="submit" class="btn btn-primary">Add Question</button>
</form>
</div>

<script>

	function addTextBox()
	{
		var text = document.getElementsByClassName('text')[0];
		var textbox = document.createElement("input");
		textbox.type = "textbox";
		textbox.classList.add("form-control");
		text.appendChild(textbox);


		var textboxes = document.querySelectorAll(".form-control");
		for (var i = 0; i < textboxes.length; i++) {
		  textboxes[i].setAttribute("name", "choices[]");
		  textboxes[i].style.textTransform = "uppercase";
		}

	}


</script>
@endsection
