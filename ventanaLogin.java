package Restaurante;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

public class ventanaLogin extends JFrame {

    public ventanaLogin() {
        setTitle("Sistema POS Restaurante ");
        setSize(400, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout());

        JLabel lblTitulo = new JLabel("Inicio de Sesión", SwingConstants.CENTER);
        lblTitulo.setFont(new Font("Arial", Font.BOLD, 18));
        add(lblTitulo, BorderLayout.NORTH);

        JPanel panelCentral = new JPanel(new GridLayout(3, 2, 10, 10));
        panelCentral.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        JLabel lblUsuario = new JLabel("Usuario:");
        JTextField txtUsuario = new JTextField();
        JLabel lblContrasena = new JLabel("Contraseña:");
        JPasswordField txtContrasena = new JPasswordField();

        panelCentral.add(lblUsuario);
        panelCentral.add(txtUsuario);
        panelCentral.add(lblContrasena);
        panelCentral.add(txtContrasena);

        add(panelCentral, BorderLayout.CENTER);


        JPanel panelBotones = new JPanel(new GridLayout(1, 2, 10, 10));
        JButton btnLogin = new JButton("Iniciar Sesión");
        JButton btnRegistro = new JButton("Registrarse");

        panelBotones.add(btnLogin);
        panelBotones.add(btnRegistro);

        add(panelBotones, BorderLayout.SOUTH);

        btnLogin.addActionListener((ActionEvent e) -> {
            String usuario = txtUsuario.getText();
            String contrasena = new String(txtContrasena.getPassword());


            if (usuario.equals("admin") && contrasena.equals("1234")) {
                JOptionPane.showMessageDialog(this, "Inicio de sesión exitoso.");
                new menu().setVisible(true); 
                dispose();
            } else {
                JOptionPane.showMessageDialog(this, "Usuario o contraseña incorrectos.", 
                        "Error", JOptionPane.ERROR_MESSAGE);
            }
        });

        btnRegistro.addActionListener((ActionEvent e) -> {
            JOptionPane.showMessageDialog(this, "Formulario de registro no implementado.");
        });
    }
}
