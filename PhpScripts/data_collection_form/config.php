<?php
	$dbHost     = 'localhost';
	$dbUsername = 'data_form';
	$dbPassword = 'data_form';
	$dbName     = 'data_form';

	// Upload directory for images and documents
	$target_img_dir = "uploads/images/";
	$target_doc_dir = "uploads/documents/";

	// Maximum image and document size in bytes
	$max_img_size = 50000; // 50 Kb
	$max_doc_size = 300000; // 300 Kb

	// Width and height constraints of image in pixels
	$max_img_height = 640;
	$max_img_width = 480;
	$min_img_width = 320;
	$min_img_height = 240;

	// Create tables
	// create table `client_data` (`rollno` int(15) NOT NULL, `image` longtext NOT NULL, `document` longtext NOT NULL, `created` datetime NOT NULL, PRIMARY KEY (`rollno`)) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
?>
