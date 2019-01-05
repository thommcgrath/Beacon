<?php

interface BeaconFTPProvider {
	public function Connect(string $host, int $port, string $user, string $pass);
	public function Close();
	
	public function ListFiles(string $remote_directory_path);
	public function Download(string $remote_file_path);
	public function Upload(string $remote_file_path, string $local_file_path);
}

?>