@extends('welcome')
@section('content')
<div class="container-fluid">
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">Laporan Transaksi Cabang</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th>No.</th>
							<th>Tanggal</th>
							<th>ID Cabang</th>
							<th>ID Trans. Laundry</th>
							<th>ID Detail Laundry</th>
							<th>ID Menu</th>
							<th>ID Pelanggan</th>
							<th>Nama</th>
							<th>No. Telp</th>
							<th>Menu</th>
							<th>Quantity</th>
							<th>Satuan</th>
							<th>Total Harga</th>
							<th>Is Paid</th>
							<th>Is Taken</th>
							<th>Waktu Pengambilan</th>
							<th>Info</th>
							<th>Selesai Dikerjakan</th>
						</tr>
					</thead>
					<tbody>
						@foreach($data as $index => $p)
						<tr>
							<td>{{$index +1}}</td>
							<td>{{date('d M Y', strtotime($p->tanggal))}}</td>
							<td>{{$p->id_cabang}}</td>
							<td>{{$p->id_transaksi_laundry}}</td>
							<td>{{$p->id_detail_laundry}}</td>
							<td>{{$p->id_menu}}</td>
							<td>{{$p->id_pelanggan}}</td>
							<td>{{$p->nama_pelanggan}}</td>
							<td>{{$p->no_telepon_pelanggan}}</td>
							<td>{{$p->nama}}</td>
							<td>{{$p->quantity}}</td>
							<td>{{$p->satuan}}</td>
							<td>{{$p->total_harga}}</td>
							<td>{{$p->is_paid}}</td>
							<td>{{$p->is_taken}}</td>
							<td>{{date('d M Y', strtotime($p->waktu_pengambilan))}}</td>
							<td>{{$p->info}}</td>
							<td>{{$p->selesai_dikerjakan}}</td>
						</tr>
						@endforeach
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
@endsection