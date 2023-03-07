@extends('admin.layout')
@section('content')
<div class="container-fluid">
		<form action="{{ route('settings.reset') }}" method="POST">
			@csrf
			<div style="display: flex; align-items: center; justify-content: center;">
				<button type="submit" class="btn btn-success" style="width: 20rem; color: white;">Reset Game</button>
			</div>
		</form>
</div>
@endsection

@section('settings')
active
@endsection