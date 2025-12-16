function morpho_gui()
    % MORPHO_GUI - Simple GUI for Morphological Operations
    % ????? ???????? ???????????? ?? ?? ?????? ?????? ????????
    
    % ????? ??????? ????????
    main_fig = figure('Name', 'Morphological Operations', ...
                      'NumberTitle', 'off', ...
                      'Position', [100, 100, 900, 600], ...
                      'MenuBar', 'none', ...
                      'ToolBar', 'none', ...
                      'Resize', 'off');
    
    % ????? ?????????
    original_img = [];
    processed_img = [];
    se_size = 3;  % ???? S ??????????
    
    % ========== ????? ????? ?????? ==========
    
    % ?? ????? ??????
    uicontrol('Parent', main_fig, ...
              'Style', 'pushbutton', ...
              'String', 'Browse Image', ...
              'Position', [30, 450, 150, 40], ...
              'FontWeight', 'bold', ...
              'FontSize', 10, ...
              'BackgroundColor', [0.8, 0.9, 1.0], ...
              'Callback', @browse_callback);
    
    % ??: ?????? ???????
    uicontrol('Parent', main_fig, ...
              'Style', 'text', ...
              'String', 'Select Operation:', ...
              'Position', [30, 400, 150, 25], ...
              'FontSize', 10, ...
              'FontWeight', 'bold', ...
              'HorizontalAlignment', 'left');
    
    % ????? ???????? (Select Box)
    popup_menu = uicontrol('Parent', main_fig, ...
                           'Style', 'popupmenu', ...
                           'String', {'Erosion', 'Dilation', 'Opening', 'Closing'}, ...
                           'Position', [30, 370, 150, 30], ...
                           'FontSize', 10, ...
                           'BackgroundColor', 'white', ...
                           'Value', 1);
    
    % ??: ???? S
    uicontrol('Parent', main_fig, ...
              'Style', 'text', ...
              'String', 'S Value (Size):', ...
              'Position', [30, 320, 150, 25], ...
              'FontSize', 10, ...
              'FontWeight', 'bold', ...
              'HorizontalAlignment', 'left');
    
    % ??? ????? ???? S
    edit_s = uicontrol('Parent', main_fig, ...
                       'Style', 'edit', ...
                       'String', '3', ...
                       'Position', [30, 290, 150, 30], ...
                       'FontSize', 10, ...
                       'BackgroundColor', 'white');
    
    % ?? ????????
    uicontrol('Parent', main_fig, ...
              'Style', 'pushbutton', ...
              'String', 'PROCESS', ...
              'Position', [30, 200, 150, 50], ...
              'FontWeight', 'bold', ...
              'FontSize', 12, ...
              'BackgroundColor', [0.1, 0.5, 0.8], ...
              'ForegroundColor', 'white', ...
              'Callback', @process_callback);
    
    % ?? ?????? ?????? ????????
    uicontrol('Parent', main_fig, ...
              'Style', 'pushbutton', ...
              'String', '<= BACK to Main', ...
              'Position', [750, 10, 130, 30], ...
              'FontSize', 9, ...
              'FontWeight', 'bold', ...
              'BackgroundColor', [0.9, 0.6, 0.4], ...
              'Callback', @back_callback);
    
    % ========== ????? ??????? ????? ==========
    
    % ?????? ????? ?????? ???????
    axes_original = axes('Parent', main_fig, ...
                         'Units', 'pixels', ...
                         'Position', [250, 100, 300, 400], ...
                         'Box', 'on');
    title(axes_original, 'Original Image', 'FontSize', 12, 'FontWeight', 'bold');
    axis(axes_original, 'image');
    axis(axes_original, 'off');
    
    % ?????? ?????? ?????? ???????
    axes_processed = axes('Parent', main_fig, ...
                          'Units', 'pixels', ...
                          'Position', [600, 100, 300, 400], ...
                          'Box', 'on');
    title(axes_processed, 'Processed Image', 'FontSize', 12, 'FontWeight', 'bold');
    axis(axes_processed, 'image');
    axis(axes_processed, 'off');
    
    % ========== ???? ???? (Callbacks) ==========
    
    function browse_callback(~, ~)
        % ??? ???? ???? ??????? ??????
        [filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp;*.tif;*.jpeg', ...
                                          'Image Files (*.jpg, *.png, *.bmp, *.tif, *.jpeg)';
                                          '*.*', 'All Files (*.*)'}, ...
                                          'Select Image File');
        
        if isequal(filename, 0)
            return; % ???????? ??? Cancel
        end
        
        % ????? ??????
        img_path = fullfile(pathname, filename);
        original_img = imread(img_path);
        
        % ??? ?????? ???????
        axes(axes_original);
        imshow(original_img);
        title('Original Image', 'FontSize', 12, 'FontWeight', 'bold');
        
        % ??? ?????? ???????
        axes(axes_processed);
        cla;
        title('Processed Image', 'FontSize', 12, 'FontWeight', 'bold');
        axis off;
        
        fprintf('? Image loaded successfully: %s\n', filename);
    end
    
    function process_callback(~, ~)
        % ?????? ?? ???? ???? ?????
        if isempty(original_img)
            errordlg('Please load an image first!', 'No Image Loaded');
            return;
        end
        
        % ?????? ??? ??????? ????????
        popup_value = get(popup_menu, 'Value');
        popup_items = get(popup_menu, 'String');
        selected_op = popup_items{popup_value};
        
        % ?????? ??? ???? S ??????? ????
        s_str = get(edit_s, 'String');
        s_value = str2double(s_str);
        
        if isnan(s_value) || s_value < 1 || s_value ~= floor(s_value)
            errordlg('S value must be a positive integer!', 'Invalid Input');
            set(edit_s, 'String', '3');
            return;
        end
        
        % ?????? ?? ?? ???? S ???? ????? ????
        if s_value > 20
            choice = questdlg(sprintf('S value (%d) is quite large. This may take time. Continue?', s_value), ...
                              'Large S Value Warning', ...
                              'Yes', 'No', 'No');
            if strcmp(choice, 'No')
                set(edit_s, 'String', '3');
                return;
            end
        end
        
        % ????? ?????? ???????
        try
            se = strel('disk', s_value);
        catch ME
            errordlg(sprintf('Error creating SE: %s\nTry smaller S value.', ME.message), 'SE Error');
            return;
        end
        
        % ????? ???? ?????? ??? "?????"
        set(main_fig, 'Pointer', 'watch');
        drawnow;
        
        % ????? ??????? ????????
        try
            switch selected_op
                case 'Erosion'
                    result = erosion(original_img, se);
                    op_name = 'Erosion';
                case 'Dilation'
                    result = dilation(original_img, se);
                    op_name = 'Dilation';
                case 'Opening'
                    result = openImg(original_img, se);
                    op_name = 'Opening';
                case 'Closing'
                    result = closeImg(original_img, se);
                    op_name = 'Closing';
                otherwise
                    error('Unknown operation selected');
            end
            
            % ??? ???????
            axes(axes_processed);
            imshow(result);
            title([op_name ' Result (S=' num2str(s_value) ')'], ...
                  'FontSize', 12, 'FontWeight', 'bold');
            
            % ??? ?????? ???????
            processed_img = result;
            
            % ????? ????
            fprintf('? Operation "%s" completed successfully with S=%d\n', op_name, s_value);
            
        catch ME
            errordlg(sprintf('Error in %s function:\n%s\n\nPlease check your function implementation.', ...
                             selected_op, ME.message), ...
                     'Processing Error');
        end
        
        % ????? ???? ?????? ??? ????? ???????
        set(main_fig, 'Pointer', 'arrow');
    end
    
    function back_callback(~, ~)
        % ???? ?????? ?????? ????????
        close(main_fig);  % ????? ????? ???????? ????????????
        run;              % ??? ?????? ????????
    end
    
    % ========== ????? ?????? ==========
    
    % ????? ?? ???????
    uicontrol('Parent', main_fig, ...
              'Style', 'text', ...
              'String', 'MORPHOLOGICAL OPERATIONS', ...
              'Position', [300, 520, 300, 30], ...
              'FontSize', 16, ...
              'FontWeight', 'bold', ...
              'ForegroundColor', [0.1, 0.3, 0.6]);
  
end