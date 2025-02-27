<?php
$servername = "mysql-service"; // El nombre del servicio MySQL en Kubernetes
$username = "user"; // El nombre de usuario de MySQL configurado
$password = "password02"; // La contraseña de MySQL configurada
$dbname = "mydatabase"; // El nombre de la base de datos MySQL configurada

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Obtener datos del formulario
$name = $_POST['name'];
$email = $_POST['email'];
$message = $_POST['message'];

// Preparar y ejecutar la consulta de inserción
$sql = "INSERT INTO form_data (name, email, message) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sss", $name, $email, $message);

if ($stmt->execute()) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

// Cerrar conexión
$stmt->close();
$conn->close();
?>
