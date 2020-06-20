document.getElementById('search-input').oninput = function() {
  var searchTerm = document.getElementById('search-input').value;
  var tbody = document.getElementById('search-content');

  for (let i = 0; i < tbody.children.length; i++) {
    var tr = tbody.children[i];
    var match = false;

    // Filter: Exclude last element because it contains only action buttons
    for (let j = 0; j < tr.children.length - 1; j++) {
      var td = tr.children[j];
      if (td.innerText.indexOf(searchTerm) !== -1) {
        match = true;
        break;
      }
    }

    tr.style.display = match ? "" : "none";
  }
};
