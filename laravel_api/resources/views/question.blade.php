<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
</head>
<body>
	<form action="{{ route('question.update') }}" method="POST">
		@csrf
		@method('put')
		<input type="text" name="question">
		<input type="text" name="answer">

		<input type="submit" name="" value="save">
	</form>
</body>
</html>