@extends('layouts.app')

@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">{{$thread->title}}</div>

                    <div class="card-body">
                        @if (session('status'))
                            <div class="alert alert-success">
                                {{ session('status') }}
                            </div>
                        @endif
                            <article>
                                <h4>{{$thread->title}}</h4>
                                <div class="body">{{$thread->body}}</div>
                            </article>
                            <hr>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
