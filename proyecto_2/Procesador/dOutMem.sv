module dOutMem #(parameter WIDTH = 24, parameter AMOUNT = 90000)
			(
			input logic clk,
			input logic we,
			input logic [WIDTH-1:0] a, wd,
			output logic [WIDTH-1:0] rd
			);
			

		logic [WIDTH-1:0] RAM4 [0:AMOUNT-1]; // [23:0] name [0:89999]-> Datos de entrada
		logic  [WIDTH-1:0] addr;
	
		//initial
			//$readmemb("G://My Drive//TEC//2023 Semestre I//Arquitectura de Computadores I//Proyectos//Proyectoll//DesarrolloProyecto//Proyecto02//mem4.txt",RAM4);					
				
	
		// READ: Salva en rd para enviarlo posteriormente al puerto de lectura.
		//assign rd = RAM4[a];  // rd[71:48] = RAM3[a[71:48]]; -> Salva en rd pixel IN del address a	
	
	
		// WRITE
		always_ff @(posedge clk) begin
			addr <= a;
			
			
			if (we && (a<(302+90000+90000)) && ((301+90000)<a)) 
				RAM4[addr] = wd;
		end	
	
		assign rd = RAM4[addr];
	
endmodule 
				
					
