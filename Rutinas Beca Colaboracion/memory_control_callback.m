function memory_control_callback(obj, event, handles)

% mem_info = imaqmem;
% mem_left_limit = 50000000;
% FrameMemoryAvailable = mem_info.FrameMemoryLimit - mem_info.FrameMemoryUsed;
% if FrameMemoryAvailable<mem_left_limit
%     flushdata(obj);
% end

flushdata(obj);