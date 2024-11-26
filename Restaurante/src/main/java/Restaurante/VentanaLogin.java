package Restaurante;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.util.ArrayList;

public class VentanaLogin extends JFrame {

    // Lista para simular una base de datos de usuarios registrados
    private ArrayList<Usuario> usuariosRegistrados;

    public VentanaLogin() {
        usuariosRegistrados = new ArrayList<>();
        // Agregar un usuario predeterminado (puedes eliminar esta parte cuando empieces a registrar usuarios)
        usuariosRegistrados.add(new Usuario("admin", "1234"));

        setTitle("Sistema POS Restaurante");
        setSize(400, 350);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout());
//CAMBIOS
        
        // Fondo de la ventana
        JPanel panelFondo = new JPanel();
        panelFondo.setBackground(new Color(46, 204, 113)); // Color verde
        panelFondo.setLayout(new BorderLayout());
        add(panelFondo, BorderLayout.CENTER);

        // Título
        JLabel lblTitulo = new JLabel("Bienvenido al Sistema POS", SwingConstants.CENTER);
        lblTitulo.setFont(new Font("Roboto", Font.BOLD, 24));
        lblTitulo.setForeground(Color.WHITE);
        panelFondo.add(lblTitulo, BorderLayout.NORTH);

        // Panel central de login
        JPanel panelCentral = new JPanel();
        panelCentral.setBackground(Color.WHITE);
        panelCentral.setLayout(new BoxLayout(panelCentral, BoxLayout.Y_AXIS));
        panelCentral.setBorder(BorderFactory.createEmptyBorder(20, 40, 20, 40));

        JLabel lblUsuario = new JLabel("Usuario:");
        lblUsuario.setFont(new Font("Arial", Font.PLAIN, 14));
        JTextField txtUsuario = new JTextField();
        txtUsuario.setPreferredSize(new Dimension(200, 30));

        JLabel lblContrasena = new JLabel("Contraseña:");
        lblContrasena.setFont(new Font("Arial", Font.PLAIN, 14));
        JPasswordField txtContrasena = new JPasswordField();
        txtContrasena.setPreferredSize(new Dimension(200, 30));

        panelCentral.add(lblUsuario);
        panelCentral.add(txtUsuario);
        panelCentral.add(Box.createVerticalStrut(20));
        panelCentral.add(lblContrasena);
        panelCentral.add(txtContrasena);

        panelFondo.add(panelCentral, BorderLayout.CENTER);

        // Panel de botones
        JPanel panelBotones = new JPanel();
        panelBotones.setBackground(Color.WHITE);
        panelBotones.setLayout(new FlowLayout());

        JButton btnLogin = new JButton("Iniciar Sesión");
        btnLogin.setFont(new Font("Roboto", Font.BOLD, 14));
        btnLogin.setBackground(new Color(52, 152, 219)); // Color azul
        btnLogin.setForeground(Color.WHITE);
        btnLogin.setPreferredSize(new Dimension(150, 40));
        btnLogin.setFocusPainted(false);
        btnLogin.setBorderPainted(false);
        btnLogin.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));

        JButton btnRegistro = new JButton("Registrarse");
        btnRegistro.setFont(new Font("Roboto", Font.BOLD, 14));
        btnRegistro.setBackground(new Color(231, 76, 60)); // Color rojo
        btnRegistro.setForeground(Color.WHITE);
        btnRegistro.setPreferredSize(new Dimension(150, 40));
        btnRegistro.setFocusPainted(false);
        btnRegistro.setBorderPainted(false);
        btnRegistro.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));

        panelBotones.add(btnLogin);
        panelBotones.add(btnRegistro);
        panelFondo.add(panelBotones, BorderLayout.SOUTH);

        // Acción del botón "Iniciar sesión"
        btnLogin.addActionListener((ActionEvent e) -> {
            String usuario = txtUsuario.getText();
            String contrasena = new String(txtContrasena.getPassword());

            // Verificar si el usuario y la contraseña existen en la lista de usuarios registrados
            boolean usuarioValido = false;
            for (Usuario u : usuariosRegistrados) {
                if (u.getUsuario().equals(usuario) && u.getContrasena().equals(contrasena)) {
                    usuarioValido = true;
                    break;
                }
            }

            if (usuarioValido) {
                JOptionPane.showMessageDialog(this, "Inicio de sesión exitoso.");
                new Menu().setVisible(true);
                dispose();
            } else {
                JOptionPane.showMessageDialog(this, "Usuario o contraseña incorrectos.",
                        "Error", JOptionPane.ERROR_MESSAGE);
            }
        });

        // Acción del botón "Registrarse"
        btnRegistro.addActionListener((ActionEvent e) -> {
            // Ventana de registro
            JFrame ventanaRegistro = new JFrame("Registro de Usuario");
            ventanaRegistro.setSize(400, 300);
            ventanaRegistro.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
            ventanaRegistro.setLocationRelativeTo(this);

            JPanel panelRegistro = new JPanel();
            panelRegistro.setLayout(new BoxLayout(panelRegistro, BoxLayout.Y_AXIS));
            panelRegistro.setBorder(BorderFactory.createEmptyBorder(20, 40, 20, 40));

            JLabel lblUsuarioRegistro = new JLabel("Nuevo Usuario:");
            JTextField txtUsuarioRegistro = new JTextField();
            JLabel lblContrasenaRegistro = new JLabel("Contraseña:");
            JPasswordField txtContrasenaRegistro = new JPasswordField();

            JButton btnRegistrar = new JButton("Registrar");
            btnRegistrar.setBackground(new Color(52, 152, 219));
            btnRegistrar.setForeground(Color.WHITE);

            panelRegistro.add(lblUsuarioRegistro);
            panelRegistro.add(txtUsuarioRegistro);
            panelRegistro.add(lblContrasenaRegistro);
            panelRegistro.add(txtContrasenaRegistro);
            panelRegistro.add(Box.createVerticalStrut(20));
            panelRegistro.add(btnRegistrar);

            ventanaRegistro.add(panelRegistro);
            ventanaRegistro.setVisible(true);

            // Acción del botón "Registrar"
            btnRegistrar.addActionListener((ActionEvent e1) -> {
                String nuevoUsuario = txtUsuarioRegistro.getText();
                String nuevaContrasena = new String(txtContrasenaRegistro.getPassword());

                if (!nuevoUsuario.isEmpty() && !nuevaContrasena.isEmpty()) {
                    // Aquí se guarda el usuario en la lista
                    usuariosRegistrados.add(new Usuario(nuevoUsuario, nuevaContrasena));
                    JOptionPane.showMessageDialog(this, "Registro exitoso.");
                    ventanaRegistro.dispose(); // Cerrar ventana de registro
                } else {
                    JOptionPane.showMessageDialog(this, "Todos los campos son obligatorios.", "Error", JOptionPane.ERROR_MESSAGE);
                }
            });
        });
    }

    // Clase interna Usuario para almacenar los datos del usuario
    class Usuario {
        private String usuario;
        private String contrasena;

        Usuario(String usuario, String contrasena) {
            this.usuario = usuario;
            this.contrasena = contrasena;
        }

        public String getUsuario() {
            return usuario;
        }

        public String getContrasena() {
            return contrasena;
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new VentanaLogin().setVisible(true);
        });
    }
}
