declare
  l_count number := 1;
  l_username varchar2(100);
  l_script clob;
begin
  l_script := '';
  while l_count <= 40 loop
          l_username := 'workshop' || l_count;
          l_script := l_script || '
drop user ' || l_username || ' cascade;';
    l_count := l_count + 1;
  end loop;
  dbms_output.put_line(l_script);
end;
