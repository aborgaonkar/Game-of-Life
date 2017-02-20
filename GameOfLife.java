/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Aashay
 */
public class GameOfLife extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            /* TODO output your page here. You may use following sample code. */
            
            String inputBoard = request.getParameter("board");
            String[] outer = inputBoard.split("\\s+");
            
            int r = outer[0].split(",").length;
            int[][] board = new int[outer.length][r];

            for(int i = 0; i < outer.length; i++)
            {
                String str = outer[i];
                String inner[] = str.split(",");
                for(int j = 0; j < inner.length; j++)
                {
                    board[i][j] = Integer.parseInt(inner[j]);
                }
            }
            
            
            int rowLength = board.length;
            int coloumnLength = board[0].length;

            int[][] extendedBoard = new int[rowLength + 2][coloumnLength + 2];
            for (int row = 1; row < extendedBoard.length - 1; row++) {
                for (int coloumn = 1; coloumn < extendedBoard[row].length - 1; coloumn++) {
                    extendedBoard[row][coloumn] = board[row - 1][coloumn - 1];
                }
            }
            for (int i = 1; i < extendedBoard.length - 1; i++) {
                for (int j = 1; j < extendedBoard[i].length - 1; j++) {
                    int sum = 0;
                    sum = extendedBoard[i - 1][j - 1] + extendedBoard[i - 1][j] + extendedBoard[i - 1][j + 1];
                    sum += extendedBoard[i][j - 1] + extendedBoard[i][j + 1];
                    sum += extendedBoard[i + 1][j - 1] + extendedBoard[i + 1][j] + extendedBoard[i + 1][j + 1];
                    if (sum < 2) {
                        board[i - 1][j - 1] = 0;
                    } else if (sum > 3) {
                        board[i - 1][j - 1] = 0;
                    } else if (sum == 3 && extendedBoard[i][j] == 0) {
                        board[i - 1][j - 1] = 1;
                    } else if ((sum == 3 || sum == 2) && extendedBoard[i][j] == 1) {
                        board[i - 1][j - 1] = 1;
                    }
                }
            }
            StringBuilder sb = new StringBuilder();
            for(int i = 0; i < board.length; i++)
            {
                for(int j = 0; j < board[i].length; j++)
                {
                    sb.append(board[i][j] + ",");
                }
                sb.append(" ");
            }
            out.println(sb.toString());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
