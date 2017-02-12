function [output] = mapTo01(inp)
	output = (inp - min(inp(:)))/(max(inp(:)) - min(inp(:)));
end