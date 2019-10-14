<?php
	$dbHost     = 'localhost';
	$dbUsername = 'data_form';
	$dbPassword = 'data_form';
	$dbName     = 'data_form';

	// Upload directory for images, signatures and documents
	$target_img_dir = "uploads/images/";
	$target_signature_dir = "uploads/signatures/";
	$target_doc_dir = "uploads/documents/";

	// Maximum image and document size in bytes
	$max_img_size = 100000; // 100 Kb
	$max_signature_size = 50000; // 50 Kb
	$max_doc_size = 300000; // 300 Kb

	// Width and height constraints of image and signature in pixels
	$min_img_width = 240;
	$min_img_height = 320;
	$max_img_width = 480;
	$max_img_height = 640;
	$min_signature_width = 210;
	$min_signature_height = 80;
	$max_signature_width = 560;
	$max_signature_height = 160;

	// Create tables
	// create table `client_data` (`rollno` int(15) NOT NULL, `image` longtext NOT NULL, `signature` longtext NOT NULL, `document` longtext, `backup` int(3) DEFAULT 0, `created` datetime NOT NULL) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
?>
