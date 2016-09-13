function saveGraphWithName(dir, name)
    set(gcf, 'Name', name);
    saveas(gcf, [dir '\' name '.fig']);
    saveas(gcf, [dir '\' name '.bmp']);
    saveas(gcf, [dir '\' name '.emf']);
    clf;
end