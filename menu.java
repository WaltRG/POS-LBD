package Restaurante;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

public class menu extends JFrame {

    public menu() {
        setTitle("Sistema Restaurante - Menú Principal");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        JMenuBar menuBar = new JMenuBar();

        JMenu menuArchivo = new JMenu("Archivo");
        JMenuItem itemCerrarSesion = new JMenuItem("Cerrar Sesión");
        JMenuItem itemSalir = new JMenuItem("Salir");

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


        JTabbedPane tabbedPane = new JTabbedPane();


        tabbedPane.addTab("Inicio", createInicioPanel());
        tabbedPane.addTab("Pedidos", createPedidosPanel());
        tabbedPane.addTab("Inventario", createInventarioPanel());

        add(tabbedPane);

        itemCerrarSesion.addActionListener((ActionEvent e) -> {
            new ventanaLogin().setVisible(true); 
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

    private JPanel createInicioPanel() {
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());
        JLabel lblBienvenida = new JLabel("Bienvenido al Sistema de Gestión del Restaurante", SwingConstants.CENTER);
        lblBienvenida.setFont(new Font("Arial", Font.BOLD, 18));
        panel.add(lblBienvenida, BorderLayout.CENTER);
        return panel;
    }

    private JPanel createPedidosPanel() {
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());

        String[] columnas = {"ID Pedido", "Cliente", "Estado", "Total"};
        Object[][] datos = {
                {"1", "Juan Pérez", "En preparación", "$150.00"},
                {"2", "Ana Gómez", "Entregado", "$200.00"}
        };

        JTable tablaPedidos = new JTable(datos, columnas);
        JScrollPane scrollPane = new JScrollPane(tablaPedidos);

        panel.add(scrollPane, BorderLayout.CENTER);

        return panel;
    }

    private JPanel createInventarioPanel() {
        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());


        String[] columnas = {"ID Producto", "Nombre", "Cantidad", "Precio"};
        Object[][] datos = {
                {"1", "Manzana", "50", "$1.00"},
                {"2", "Leche", "30", "$2.50"}
        };

        JTable tablaInventario = new JTable(datos, columnas);
        JScrollPane scrollPane = new JScrollPane(tablaInventario);

        panel.add(scrollPane, BorderLayout.CENTER);

        return panel;
    }
}
