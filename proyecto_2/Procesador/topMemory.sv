
/*
	To Do: definir bien los tamanos de las memorias
	Memory with segmentation
	Inputs:
	- clk: the clock
	- we: enables writing on data segment
	- a1: instruction segment address
	- a2: //Read data. Se usa solo el a2 que es quien contiene la direccion de mem de los datos a read/write.
	- wd: data to write on data segment
	Outputs:
	- rd1: instruction requested
	- rd2: data requested
*/

module topMemory #(parameter WIDTH = 24, parameter INSTRUCTIONWIDTH = 24)
  (input logic clk, we, startIO,        		// 1bit
	input logic [WIDTH-1:0]  a2, wd,  		// [23:0]
	output logic [WIDTH-1:0] rd2);				// [23:0]
	
	// Mantiene valor del input startIO y lo extiende
	logic [WIDTH-1:0] startIOExtended;         // 23:0
	assign startIOExtended[WIDTH-1:1] = 24'b0; // 23:1
	assign startIOExtended[0] = startIO;		 // [0]
	
	
	logic [WIDTH-1:0] rd_seno, rd_in, rd_out;
		    	
	
	// Seno Function MEMORY ROM
	senFuncMem #(24,302) // Sen Func Mem
		senoFuncMem(a2,rd_seno);
		
	dInMem #(24,90000) // In data
		dataInMem(clk,we,a2-24'd302,wd,rd_in);

	dOutMem #(24,90000) //Out data
		dataOutMem(clk,we,a2-24'd90302,wd,rd_out);	
	
	// Se usa solo el a2(address) que es quien contiene la direccion de mem de los datos a read/write.
	always_comb begin
		//>>>>>>>>>>>>>>>>>>>>>>> Read data
		rd2 = 0;
		// -------------- Switch de inicio. Se necesita al inicio del programa, donde, si rd2 = 1 se inicia y si no se espera a que este tenga tal valor.
		if (a2==180302) rd2 = startIOExtended; 
		else if (a2<302) rd2 = rd_seno; 					// 0<=a2<=301        | Funcion Seno    [47:24]
		else if (a2<302+90000) rd2  = rd_in; 			// 302<=a2<=90301    | Pixel entrada.  [71:48]
		else if (a2<302+90000+90000)  rd2  = rd_out; // 90302<=a2<=180301.| Pixel salida    [95:72]
		
	end
	
endmodule
