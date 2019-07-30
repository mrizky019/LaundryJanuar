<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        @include('includes.head')
    </head>
    <body>
        <div id="wrapper">
            @include('includes.sidebar')

            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content" class="content">
                    @include('includes.header')

                    @yield('content')
                </div>
                @include('includes.footer')  
            </div>
        </div>
        @include('includes.modal')
        @include('includes.js')
    </body>
</html>
