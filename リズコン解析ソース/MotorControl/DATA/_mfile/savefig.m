function savefig( bSaveFig , name)

%UNTITLED4 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
    if bSaveFig ==1
        saveas(gcf, [name,'.fig']);
        hgexport(gcf, [name,'.png'] ,hgexport('factorystyle'),'Format','png' );
        hgexport(gcf, [name,'.emf'] ,hgexport('factorystyle'),'Format','meta' );
        hgexport(gcf, [name,'.tif'] ,hgexport('factorystyle'),'Format','tiffn' );
    end

end

