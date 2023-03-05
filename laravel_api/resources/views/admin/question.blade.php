@extends('admin.layout')
@section('content')
<div class="container-fluid">
<form action="{{ route('dashboard.save') }}" method="POST">
	@csrf
  <div class="mb-3" style="display: flex; justify-content:center; align-items: flex-start; flex-direction: column;">
    <label for="question" class="form-label">Question</label>
    <textarea name="message" class="form-label" style="width: 100%; border: 1px solid grey;"></textarea>
  </div>
  <div class="mb-3">
    <label for="choices" class="form-label">Choices</label>
    <button type="button" style="display: flex; justify-content: center; align-items: center; margin-bottom: 1rem;" class="btn btn-info" onclick="addTextBox()" style="height: 20px;">+</button>
    <div class="text" style="display: flex; justify-content: center; align-items: center; gap: 4px; flex-direction: column;">
    </div>
    <div class="text" style="margin-top: 1rem; ">
    	<label for="answer" class="form-label">Answer</label>
    	<select class="form-select" aria-label="Default select example" id="answer" name="answer">
		  <option selected>Open this select menu</option>
		  <option value="1">One</option>
		  <option value="2">Two</option>
		  <option value="3">Three</option>
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
		}
	}
</script>
@endsection
