function savefig( bSaveFig , name)

%UNTITLED4 この関数の概要をここに記述
%   詳細説明をここに記述
    if bSaveFig ==1
        saveas(gcf, [name,'.fig']);
        hgexport(gcf, [name,'.png'] ,hgexport('factorystyle'),'Format','png' );
        hgexport(gcf, [name,'.emf'] ,hgexport('factorystyle'),'Format','meta' );
        hgexport(gcf, [name,'.tif'] ,hgexport('factorystyle'),'Format','tiffn' );
    end

end

