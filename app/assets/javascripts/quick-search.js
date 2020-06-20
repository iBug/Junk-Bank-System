document.getElementById('search-input').oninput = function() {
  var searchTerm = document.getElementById('search-input').value;
  var searchRegex = undefined;
  try {
    searchRegex = new RegExp(searchTerm);
  } catch {
    // Bad regex, ignore
  }
  var tbody = document.getElementById('search-content');

  for (let i = 0; i < tbody.children.length; i++) {
    var tr = tbody.children[i];
    var match = false;
    var texts = [];

    // Filter: Exclude last element because it contains only action buttons
    for (let j = 0; j < tr.children.length - 1; j++) {
      var td = tr.children[j];
      texts.push(td.innerText);
    }
    var text = texts.join("\n");

    if (text.indexOf(searchTerm) !== -1) {
      match = true;
    } else if (typeof searchRegex !== "undefined" && searchRegex.test(text)) {
      match = true;
    }
    tr.style.display = match ? "" : "none";
  }
};
