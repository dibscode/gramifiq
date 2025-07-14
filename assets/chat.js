document.addEventListener("DOMContentLoaded", function () {
  var chatForm = document.getElementById("chatForm");
  var messageInput = document.getElementById("message");
  var responseDiv = document.getElementById("response");

  chatForm.onsubmit = function (e) {
    e.preventDefault();
    var msg = messageInput.value;
    responseDiv.innerHTML = '<span style="color:gray">Memproses...</span>';
    fetch("../api/chatgpt.php", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: "message=" + encodeURIComponent(msg),
    })
      .then((res) => {
        if (!res.ok) throw new Error("Gagal koneksi ke server");
        return res.text();
      })
      .then((text) => {
        let data;
        try {
          data = JSON.parse(text);
        } catch (e) {
          responseDiv.innerHTML = '<span style="color:red">Response tidak bisa diparse sebagai JSON:<br>' + text + "</span>";
          return;
        }
        if (data.choices && data.choices[0] && data.choices[0].message && data.choices[0].message.content) {
          responseDiv.innerHTML = data.choices[0].message.content;
        } else {
          responseDiv.innerHTML = '<span style="color:red">Format response API salah:<br>' + text + "</span>";
        }
      })
      .catch((err) => {
        responseDiv.innerHTML = '<span style="color:red">Error: ' + err.message + "</span>";
      });
  };
});
