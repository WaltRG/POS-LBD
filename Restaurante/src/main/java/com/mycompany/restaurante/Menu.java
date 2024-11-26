package com.mycompany.restaurante;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

public class Menu extends JFrame {

    public Menu() {
        setTitle("Sistema Restaurante - Menú Principal");
        setSize(900, 700);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout());

        // Fondo con gradiente
        JPanel panelFondo = new JPanel() {
            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                Graphics2D g2d = (Graphics2D) g;
                GradientPaint gradiente = new GradientPaint(0, 0, new Color(33, 150, 243), getWidth(), getHeight(), new Color(0, 188, 212));
                g2d.setPaint(gradiente);
                g2d.fillRect(0, 0, getWidth(), getHeight());
            }
        };
        panelFondo.setLayout(new BorderLayout());
        add(panelFondo);

        // Menú superior
        JMenuBar menuBar = new JMenuBar();
        menuBar.setBackground(new Color(33, 150, 243));

        JMenu menuArchivo = new JMenu("Archivo");
        JMenuItem itemCerrarSesion = new JMenuItem("Cerrar Sesión");
        JMenuItem itemSalir = new JMenuItem("Salir");

        itemCerrarSesion.setBackground(new Color(33, 150, 243));
        itemSalir.setBackground(new Color(33, 150, 243));

        menuArchivo.add(itemCerrarSesion);
        menuArchivo.add(itemSalir);

        JMenu menuGestion = new JMenu("Gestión");
        JMenuItem itemUsuarios = new JMenuItem("Gestión de Usuarios");
        JMenuItem itemProductos = new JMenuItem("Gestión de Productos");
        JMenuItem itemPedidos = new JMenuItem("Gestión de Pedidos");
        JMenuItem itemInventario = new JMenuItem("Gestión de Inventario");

        menuGestion.add(itemUsuarios);
        menuGestion.add(itemProductos);
        menuGestion.add(itemPedidos);
        menuGestion.add(itemInventario);

        JMenu menuReportes = new JMenu("Reportes");
        JMenuItem itemVentas = new JMenuItem("Reporte de Ventas");
        JMenuItem itemProveedores = new JMenuItem("Reporte de Proveedores");

        menuReportes.add(itemVentas);
        menuReportes.add(itemProveedores);

        JMenu menuAyuda = new JMenu("Ayuda");
        JMenuItem itemAcercaDe = new JMenuItem("Acerca de");

        menuAyuda.add(itemAcercaDe);

        menuBar.add(menuArchivo);
        menuBar.add(menuGestion);
        menuBar.add(menuReportes);
        menuBar.add(menuAyuda);

        setJMenuBar(menuBar);

        // Panel de pestañas (JTabbedPane)
        JTabbedPane tabbedPane = new JTabbedPane();
        tabbedPane.setFont(new Font("Roboto", Font.PLAIN, 16));
        tabbedPane.setBackground(new Color(255, 255, 255, 100));
        tabbedPane.addTab("Inicio", createInicioPanel());
        tabbedPane.addTab("Pedidos", createPedidosPanel());
        tabbedPane.addTab("Inventario", createInventarioPanel());

        panelFondo.add(tabbedPane, BorderLayout.CENTER);

        // Acciones de los menús
        itemCerrarSesion.addActionListener((ActionEvent e) -> {
            new VentanaLogin().setVisible(true); 
            dispose(); 
        });

        itemSalir.addActionListener((ActionEvent e) -> {
            System.exit(0); 
        });

        itemAcercaDe.addActionListener((ActionEvent e) -> {
            JOptionPane.showMessageDialog(this, "Sistema POS Restaurante \nDesarrollado por Tu GRUPO 7.", 
                    "Acerca de", JOptionPane.INFORMATION_MESSAGE);
        });
    }

    // Panel de inicio
    private JPanel createInicioPanel() {
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());
        JLabel lblBienvenida = new JLabel("Bienvenido al Sistema de Gestión del Restaurante", SwingConstants.CENTER);
        lblBienvenida.setFont(new Font("Roboto", Font.BOLD, 22));
        lblBienvenida.setForeground(new Color(255, 255, 255));
        panel.setBackground(new Color(33, 150, 243));
        panel.add(lblBienvenida, BorderLayout.CENTER);
        return panel;
    }

    // Panel de pedidos
    private JPanel createPedidosPanel() {
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());

        String[] columnas = {"ID Pedido", "Cliente", "Estado", "Total"};
        Object[][] datos = {
                {"1", "Juan Pérez", "En preparación", "$150.00"},
                {"2", "Ana Gómez", "Entregado", "$200.00"}
        };

        JTable tablaPedidos = new JTable(datos, columnas);
        tablaPedidos.setFont(new Font("Roboto", Font.PLAIN, 14));
        tablaPedidos.setRowHeight(30);
        JScrollPane scrollPane = new JScrollPane(tablaPedidos);

        panel.add(scrollPane, BorderLayout.CENTER);

        return panel;
    }

    // Panel de inventario
    private JPanel createInventarioPanel() {
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());

        String[] columnas = {"ID Producto", "Nombre", "Cantidad", "Precio"};
        Object[][] datos = {
                {"1", "Manzana", "50", "$1.00"},
                {"2", "Leche", "30", "$2.50"}
        };

        JTable tablaInventario = new JTable(datos, columnas);
        tablaInventario.setFont(new Font("Roboto", Font.PLAIN, 14));
        tablaInventario.setRowHeight(30);
        JScrollPane scrollPane = new JScrollPane(tablaInventario);

        panel.add(scrollPane, BorderLayout.CENTER);

        return panel;
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new Menu().setVisible(true);
        });
    }
}
