@extends('welcome')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-body" style="text-align: center; font-weight: bold">
                    @if (session('status'))
                        <div class="alert alert-success" role="alert">
                            {{ session('status') }}
                        </div>
                    @endif
                    @if (Route::has('login'))
                        @auth
                            You are logged in!
                        @else
                            Please, Login
                        @endauth
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
