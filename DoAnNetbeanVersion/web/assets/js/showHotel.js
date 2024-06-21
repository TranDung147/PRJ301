function getData(div) {
    var id = div.id;

    var form = document.createElement('form');
    form.method = 'GET';
    form.action = 'ShowHotelsServlet';  // Đảm bảo URL này là đúng

    var input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'id';
    input.value = id;
    form.appendChild(input);

    document.body.appendChild(form);
    form.submit();
}
