@extends('welcome')
@section('content')
<div class="container-fluid">
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">Laporan Stock Cabang</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th>No.</th>
							<th>ID Cabang</th>
							<th>ID Item</th>
							<th>Nama Barang</th>
							<th>Total Barang</th>
						</tr>
					</thead>
					<tbody>
						@foreach($data as $index => $p)
						<tr>
							<td>{{$index +1}}</td>
							<td>{{$p->id_cabang}}</td>
							<td>{{$p->id_item}}</td>
							<td>{{$p->nama}}</td>
							<td>{{$p->total}}</td>
						</tr>
                        @endforeach
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
@endsection