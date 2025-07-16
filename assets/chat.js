document.addEventListener("DOMContentLoaded", function () {
  var chatForm = document.getElementById("chatForm");
  var messageInput = document.getElementById("message");
  var responseDiv = document.getElementById("response");
  var submitBtn = chatForm.querySelector("button[type='submit']");

  chatForm.onsubmit = function (e) {
    e.preventDefault();
    var msg = messageInput.value;
    responseDiv.innerHTML = '<span style="color:gray">Memproses...</span>';
    messageInput.disabled = true;
    if (submitBtn) submitBtn.disabled = true;
    fetch("https://apicesabotz.biz.id/bard-ai.php?text=" + encodeURIComponent(msg))
      .then((res) => {
        if (!res.ok) throw new Error("Gagal koneksi ke server");
        return res.text();
      })
      .then((text) => {
        let data;
        try {
          data = JSON.parse(text);
        } catch (e) {
          // Jika bukan JSON, tampilkan raw text (bisa error HTML, rate limit, dsb)
          responseDiv.innerHTML = '<span style="color:red">Response tidak bisa diparse sebagai JSON:<br>' + text + "</span>";
          messageInput.disabled = false;
          if (submitBtn) submitBtn.disabled = false;
          return;
        }
        if (data.status && data.result && data.result.text) {
          responseDiv.innerHTML = data.result.text;
        } else if (data.error) {
          responseDiv.innerHTML = '<span style="color:red">Error: ' + data.error + "</span>";
        } else {
          responseDiv.innerHTML = '<span style="color:red">Format response API salah:<br>' + JSON.stringify(data) + "</span>";
        }
        messageInput.value = "";
        messageInput.focus();
        setTimeout(() => {
          responseDiv.scrollIntoView({ behavior: "smooth", block: "end" });
        }, 100);
      })
      .catch((err) => {
        responseDiv.innerHTML = '<span style="color:red">Error: ' + err.message + "</span>";
      })
      .finally(() => {
        messageInput.disabled = false;
        if (submitBtn) submitBtn.disabled = false;
      });
  };
});
