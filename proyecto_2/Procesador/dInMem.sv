module dInMem #(parameter WIDTH = 24, parameter AMOUNT = 90000) 
			(
			input logic clk,
			input logic we,
			input logic [WIDTH-1:0] a, wd,
			output logic [WIDTH-1:0] rd
			);
			

		logic [WIDTH-1:0] RAM3 [0:AMOUNT-1]; // [23:0] name [0:89999]-> Datos de entrada
		logic  [WIDTH-1:0] addr;
	
		initial		
		
			$readmemb("C://Users//HP//Desktop//TEC//I-2023//Arqui-I//Repo//jpena_computer_architecture_1_2023//proyecto_2//Procesador//mem3.txt",RAM3);					
					
		// READ: Salva en rd para enviarlo posteriormente al puerto de lectura.
		//assign rd = RAM3[a];  // rd[71:48] = RAM3[a[71:48]]; -> Salva en rd pixel IN del address a	
	
	
		// WRITE
		always_ff @(posedge clk) begin    
			addr <= a;
			
			if (we && (a<302+90000) && (301<a)) 
				RAM3[addr] <= wd;
		end
	
	
		// READ: Salva en rd para enviarlo posteriormente al puerto de lectura.
		assign rd = RAM3[addr];  // rd[71:48] = RAM3[a[71:48]]; -> Salva en rd pixel IN del address a		
	
endmodule 
